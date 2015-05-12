From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 11 May 2015 18:32:52 -0700
Subject: [PATCH] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <CAJ+vNU0j47Wk5mbZE-Q1=8uVtx7k3HC-YJXCgWzUwu3TGDu0bg@mail.gmail.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
 <CAOMZO5BU4msRswEujw=DC=HdsZY5S3YeG9KYNFxf3cwiFY6n2g@mail.gmail.com>
 <CAJ+vNU0j47Wk5mbZE-Q1=8uVtx7k3HC-YJXCgWzUwu3TGDu0bg@mail.gmail.com>
Message-ID: <20150512013251.GF4810@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 06:31:55AM -0700, Tim Harvey wrote:
> On Mon, May 11, 2015 at 5:26 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Thu, Apr 30, 2015 at 1:02 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> >> +               /* The maximum die temp is specified by the Temperature Grade */
> >> +               switch ((val >> 6) & 0x3) {
> >> +               case 0: /* Commercial (0 to 95C) */
> >> +                       data->temp_grade = "Commercial";
> >> +                       data->temp_critical = 95000;
> >> +                       break;
> >> +               case 1: /* Extended Commercial (-20 to 105C) */
> >> +                       data->temp_grade = "Extended Commercial";
> >> +                       data->temp_critical = 105000;
> >> +                       break;
> >
> > Looks good, only a minor suggestion for consistency: could you please
> > change "Commercial" to "Consumer"?
> >
> > This is the term that is referenced in the datasheet, so better keep
> > it consistent.
> >
> > Thanks
> 
> Fabio,
> 
> Actually this seems to be very inconsistent from Freescale and the
> register uses the word 'commercial' - I think you are referring to the
> part identifier which is part of the ordering information. The Part
> Number Nomenclature in the 'datasheets' use the word 'Commercial' in
> the temperature grade field and the word 'Consumer' in some (but not
> all) of the Part differentiator field. The register description uses
> the word Commercial. I believe this is more of a marketing term than
> anything else so I don't really care what word is used. I've heard the
> word commercial used in terms of temperature grades and not consumer
> personally.
> 
> I should note that the actual OTP fuse I'm looking at is only
> described in the IMX6DQRM (Reference manual for the DUAL and QUAD) and
> is shown as 'reserved' in the IMX6SDLRM (SOLO and DUALLITE Reference
> Manual) and the 'IMX6SXRM' for the SX. I have been able to show
> expirimentaly that the speed grade and temperature grade OTP's exist
> in the IMX6SDL (even though they are marked as 'reserved' in the RM)
> but I do not have an IMX6SX to see if the same is true. I have a query
> out to our FAE for clarification on the OTP registers.


Fabio, any particular preference ? Is the patch good to with the current
nomenclature?

> 
> Tim
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/fba9f6d7/attachment.sig>
