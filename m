From: philippe.retornaz@gmail.com (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Mon, 02 Dec 2013 09:30:31 +0100
Subject: [PATCH RESEND] mfd: mc13xxx: Fix null pointer dereference in
 mc13xxx_common_init
In-Reply-To: <1385805188-5597-1-git-send-email-shc_work@mail.ru>
References: <1385805188-5597-1-git-send-email-shc_work@mail.ru>
Message-ID: <529C4527.3040707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/11/2013 10:53, Alexander Shiyan a ?crit :
> If this driver being loaded from devicetree, the pdata is NULL. This
> cause kernel Oops when "fsl,mc13xxx-uses-codec" and/or
> "fsl,mc13xxx-uses-touch" properties is specified.
>

Well, the codec and touch are not supported if DT is used, thus why
bothering ? Just don't specify thoses properties.

IMHO it would be better to either implement full DT support in the
subdevices or removing the check for the fsl,mc13xxx-uses-codec and
fsl,mc13xxx-uses-touch in mc13xxx_probe_flags_dt().
If it's not supported let's not lie about it.


Regards,

Philippe
