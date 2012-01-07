From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Jan 2012 12:20:23 +0100
Subject: [PATCH] at91: fix at91rm9200 soc subtype handling
In-Reply-To: <4F02C900.6090907@atmel.com>
References: <1325070604-5560-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <4F01BD7C.6000902@atmel.com> <4F02C900.6090907@atmel.com>
Message-ID: <20120107112023.GD2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:23 Tue 03 Jan     , Nicolas Ferre wrote:
> On 01/02/2012 03:21 PM, Nicolas Ferre :
> > On 12/28/2011 12:10 PM, Veli-Pekka Peltola :
> >> BGA should be the default SoC subtype but it is set to unknown if
> >> not explicitly set to PQFP. Currently setting it to PQFP sets subtype
> >> to BGA as subtypes are swapped in at91rm9200_set_type().
> >>
> >> Wrong subtype causes GPIO bank D not to work at all.
> >>
> >> After this fix BGA subtype is set as default. On boot BGA is printed
> >> always but it is set to PQFP if requested before setting amount of GPIO
> >> banks.
> >>
> >> Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > I will queue it in a "fixes" branch (hopefully for 3.3).
> 
> I come back to this:
> 1/ There is definitively a bug in at91rm9200_set_type()
> 2/ I do not know if it is a good idea to set BGA subtype by default. I
> would simply keep the "unknown" subtype printed out until the real
> subtype is set by the "*_init_early()" of the board code.
> 
> So, I may modify your original patch and submit it for discussion...
> Jean-Christophe, I would like to have your opinion on this.
agreed

Best Regards,
J.
