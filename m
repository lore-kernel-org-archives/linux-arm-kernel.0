From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 25 Jun 2014 16:07:53 -0700
Subject: [PATCH v1 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <53AB46E0.5010908@wwwdotorg.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-3-git-send-email-abrestic@chromium.org>
 <53AB46E0.5010908@wwwdotorg.org>
Message-ID: <CAL1qeaH+pfyJKQyS3=7M7C6QGFkm3r5ssDohur7KUwk2EXG2tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 3:02 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
>> The Tegra XHCI controller communicates requests to the host through
>> a mailbox interface.  Host drivers which can handle these requests,
>> such as the Tegra XUSB pad controller driver and upcoming Tegra XHCI
>> host controller driver, can send messages and register to be notified
>> of incoming messages.
>
>> diff --git a/include/linux/tegra-xusb-mbox.h b/include/linux/tegra-xusb-mbox.h
>
>> +extern int tegra_xusb_mbox_register_notifier(struct tegra_xusb_mbox *mbox,
>> +                                          struct notifier_block *nb);
>> +extern void tegra_xusb_mbox_unregister_notifier(struct tegra_xusb_mbox *mbox,
>> +                                             struct notifier_block *nb);
>> +extern int tegra_xusb_mbox_send(struct tegra_xusb_mbox *mbox,
>> +                             enum tegra_xusb_mbox_cmd cmd, u32 data);
>> +extern struct tegra_xusb_mbox *
>> +tegra_xusb_mbox_lookup_by_phandle(struct device_node *np, const char *prop);
>
> This seems to use a custom API. I've seen mention of a mailbox
> subsystem, and I assume that has a standardized API. Should this driver
> implement that instead?

All the mailbox drivers currently use a custom API, but there is
indeed a patch series floating around to create a generic mailbox
framework, though it hasn't landed in -next yet.  I can take a look at
how this driver would fit into that framework.
