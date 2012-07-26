From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 26 Jul 2012 11:45:44 +0100
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
 <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
 <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
Message-ID: <1343299544.9295.36.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-26 at 10:24 +0800, Huang Shijie wrote:
> But you have added "depend on MXS_DMA". So If you do not select the
> mxs-dma, you can not see the gpmi-nand. 

That's an issue with the 'make *config' tools. I recommend fixing those
instead; it's horrid to use 'select' on an option which *is*
user-visible, such as CONFIG_MXS_DMA.

In the mid-1990s, there was a variant of the tcl 'make xconfig' which
would *show* you the dependencies for things, and would allow you to
turn them on with a single click. Is that really so hard for us to do?

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/07b8ffc0/attachment.bin>
