From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 8 May 2015 13:53:36 -0700
Subject: [PATCH v8 6/9] mailbox: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <CANLzEksWtzSmz=OCuwVdY5RSG6gDrOoMyGsW3i9jMcjD3WtPKQ@mail.gmail.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-7-git-send-email-abrestic@chromium.org>
 <CANLzEksWtzSmz=OCuwVdY5RSG6gDrOoMyGsW3i9jMcjD3WtPKQ@mail.gmail.com>
Message-ID: <CAL1qeaGfZtwNKxn=dT9DQ-c-j2X7Vi5jLtXx86zq2KscM8AFfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 8, 2015 at 1:42 PM, Benson Leung <bleung@chromium.org> wrote:
> On Mon, May 4, 2015 at 10:36 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb-mbox".
>> +   Otherwise, must contain '"nvidia,<chip>-xusb-mbox",
>> +   "nvidia,tegra124-xusb-mbox"' where <chip> is tegra132.
>
> The driver doesn't seem to have any particular entry for tegra132, so
> that would be a bad example.

The convention on Tegra is to use "nvidia,<chip>-<ip>" for each IP
block.  Additionally, since the XUSB-related blocks on Tegra132 are
identical to Tegra124, these devices on Tegra132 are 'compatible' with
their Tegra124 variants.

For some context, see Paul's comments in commit 193c9d23
("Documentation: DT bindings: add more Tegra chip compatible
strings").

Thanks,
Andrew
