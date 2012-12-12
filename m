From: phil.edworthy@renesas.com (phil.edworthy at renesas.com)
Date: Wed, 12 Dec 2012 09:57:38 +0000
Subject: [PATCH v2] ARM: shmobile: r8a7779: Fix GPIO input reg addresses
In-Reply-To: <2861660.bMP77HcQxX@avalon>
References: <16942826.W5hEBZUpzF@avalon>
 <1355225657-18731-1-git-send-email-phil.edworthy@renesas.com>
 <2861660.bMP77HcQxX@avalon>
Message-ID: <OF451D0336.7B8D9EBA-ON80257AD2.00367B07-80257AD2.0036B723@eu.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Laurent,

> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Phil Edworthy <phil.edworthy@renesas.com>,
> Cc: Simon <horms@verge.net.au>, linux-sh at vger.kernel.org, linux-arm-
> kernel at lists.infradead.org, Magnus <magnus.damm@gmail.com>, Laurent
> Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date: 11/12/2012 11:39
> Subject: Re: [PATCH v2] ARM: shmobile: r8a7779: Fix GPIO input reg addresses
>
> On Tuesday 11 December 2012 11:34:17 Phil Edworthy wrote:
> > The INDTx register addresses were wrong.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>
> You can add
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Please scrap this patch. I just found out that it screws up the GPIO outputs. The current code assumes the same register is used for both input and
output, which is not the case. It needs a bit of work to fix this.

Thanks
Phil
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/f7cdbc2a/attachment-0001.html>
