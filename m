From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 4 Apr 2012 02:00:35 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7B1273.6020003@compulab.co.il>
Message-ID: <1333501235.68285.YahooMailClassic@web29020.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

--- On Tue, 3/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hmmm....
> If we change the GPSR and GPCR, the old levels should be
> reserved, right?
> Attached...

Your patch - pxa2xx-mfp2.patch - doesn't introduce any problems, but
I never had a failure case that could be used to prove the patch fixes
the direction/PGSR window bug. In theory the patch *should* fix it.

As for restoring the GPIO levels via GPSR and GPCR, that does seem
to work. Certainly the regular GPIO (AF0) outputs have their levels
restored OK.

Regards,
Paul
