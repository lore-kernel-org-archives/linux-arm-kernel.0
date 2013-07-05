From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Jul 2013 00:03:48 -0700
Subject: [RFC 0/4] Cleanup PRM and CM regbit headers
In-Reply-To: <51D65CE8.4050004@ti.com>
References: <1372076143-12955-1-git-send-email-rnayak@ti.com>
 <20130625071428.GC5523@atomide.com> <51C95839.6050307@ti.com>
 <20130704115819.GJ5523@atomide.com> <51D56743.9080800@ti.com>
 <alpine.DEB.2.02.1307041627540.6258@utopia.booyaka.com>
 <51D65CE8.4050004@ti.com>
Message-ID: <20130705070347.GP5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130704 22:49]:
> On Thursday 04 July 2013 10:14 PM, Paul Walmsley wrote:
> > You mentioned that these patches were generated with some kind of awk/grep 
> > scripting.  Can you integrate that in an automated way into the 
> > autogeneration flow?  If the answer is yes, then keep the header.  If the 
> > answer is no, then the header should be dropped.  Beno?t, maybe you have 
> > an opinion too?
> 
> Ok, I'll try and integrate those scripts so all this can be done in an
> automated way even for newer SoCs.
> 
> > 
> > As far as whether this should go in -rcX or not, my view is that, as a 
> > matter of policy, large changes like this should wait until v3.12.  Now, 
> > having written that, I also was under the impression that the OMAP5 
> > changes weren't going to be sent upstream unless the total diffstat would 
> > be balanced to roughly zero or negative lines.  As far as I know, that 
> > didn't happen.  So I guess, v3.11-rc it is...  kernel development by 
> > diffstat :-(
> 
> I don't mind these going in -rcX or 3.12, either way is fine.

Removal of unused code should be OK for the early -rc. I doubt that
anybody would object it especially considering that's it's a huge
pile of unused defines that most likely won't ever be needed for
DT based booting.
 
> > Finally, please repost the whole series once you're done with your 
> > changes, as a non-RFC, along with your pull request (if you plan to send 
> > one).  I guess I should be the one to take these, since I wound up taking 
> > the OMAP5 addition...
> 
> :) I thought so too that you should be the one sending the pull.
> I will post these out as non-RFC after I do a clean integration into
> the autogen scripts, and then you can take a call on sending the pull for
> either -rcX or 3.12

I'd prefer to have it done now for the early -rc series. But if it
drags on, we should not merge it during the -rc series.

Regards,

Tony
