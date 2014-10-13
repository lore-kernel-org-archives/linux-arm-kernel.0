From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 13 Oct 2014 12:12:18 -0400
Subject: [PATCH v3 6/8] phy: miphy28lp: Add SSC support for PCIE
In-Reply-To: Your message of "Mon, 13 Oct 2014 10:16:06 +0200."
 <CAG374jBJcX00S4nSugWXaUxAQV3Bwp+OxY0c2GJ-+rskzDzpGw@mail.gmail.com>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>
 <1411721657-9924-7-git-send-email-gabriel.fernandez@linaro.org>
 <15685.1412018368@turing-police.cc.vt.edu>
 <CAG374jBJcX00S4nSugWXaUxAQV3Bwp+OxY0c2GJ-+rskzDzpGw@mail.gmail.com>
Message-ID: <4723.1413216738@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Oct 2014 10:16:06 +0200, Gabriel Fernandez said:

> Concerning multiple writing in MIPHY_PLL_SBR_1, the writing of the
> first 0 it's to be sure there is no previous request.
> Then we take account new setting by writing 0x02.
> And then we make it 0 to make sure there is no other pending requests.
>
> I added comments and macro to be more clear (see the code below).

Thanks, that will be a lot clearer to some poor soul down the road who
has to delve in here (possibly to figure out if a new part can use the
same driver and/or what changes need to be made).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/bc693513/attachment.sig>
