From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Oct 2013 10:17:07 -0300
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131015131038.GB25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 10:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Another point on patch 1.  Sorry, I don't have patch 1 to reply to, it
> seems it was deleted from linux-arm-kernel's moderation queue.
>
> drm_mode_connector_attach_encoder() is called too early, before the
> base.id field in the encoder has been initialised.  This causes the
> connectors encoder array to be empty, and userspace KMS to fail.
>
> There's also bugs in the CSC setting too - it runs off the end of the
> array and gcc warns about this.  The code was clearly wrong.
>
> You may wish to combine this patch with patch 1 to sort all that out.
> For the patch below:
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, Russell.

Will submit v3 when I am back to the office.

Regards,

Fabio Estevam
