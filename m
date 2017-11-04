From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 4 Nov 2017 17:21:11 +0530
Subject: [PATCH v4 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <1509720477-18936-4-git-send-email-sudeep.holla@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <CABb+yY0KR7rzUSqrG7vPJDZONK3rXtk03WX2eTGAdmkpvTUEbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 8:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

.....

> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> +{
> +       int ret;
> +       int timeout;
> +       struct scmi_info *info = handle_to_scmi_info(handle);
> +       struct device *dev = info->dev;
> +
> +       ret = mbox_send_message(info->tx_chan, xfer);
>                                                                           ^^^^^^^^
The call still remains unchanged and broken.
https://lkml.org/lkml/2017/7/24/502
