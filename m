From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Jun 2015 13:01:37 -0700
Subject: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
In-Reply-To: <20150601193328.GA27640@squirrel.local>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
 <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
 <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
 <CAALWOA9wyCsUQqER2Cqwru_2REpX6AeryWeoSuwZWDsdPPL+Ow@mail.gmail.com>
 <20150601172330.GX30984@atomide.com>
 <20150601193328.GA27640@squirrel.local>
Message-ID: <20150601200137.GC30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150601 12:35]:
> On 1 June 2015 at 19:23, Tony Lindgren <tony@atomide.com> wrote:
> > Ah finally you got around doing a proper patch :)
> 
> My First Linux Patch(tm) ;-)

Probably easier than trying to get other people to do the right
thing by writing emails ;)
 
> > Also, if this is needed as a fix for the mainline kernel to avoid hardware
> > damage, please let me know too ASAP.
> 
> The damaging configuration is having &rtc { system-power-controller; }
> without &tps { ti,pmic-shutdown-controller; }

OK thanks updating the description with that.
 
> So 3d76be5b9 also avoids damage, but with the unfortunate side-effect
> that the system doesn't power off at all anymore (it just halts). I do
> recommend applying this patch (restyled as needed) before reverting
> 3d76be5b9.
> 
> > Hmm no ideas about that, I guess people are using gmail to send email
> > with smtps though?
> 
> Hmm, setting up mutt turned out less hassle than I remembered...
> 
> (Let's hope all goes well)
> 
> > Linux usually does not use the // style comments.. Can you please change
> > that? And how about have just one section of comments then the entry
> > for ti,pmic-shutdown-controller?
> 
> Fresh try...

Thanks applying into omap-for-v4.1/fixes with Cc stable.

Regards,

Tony
