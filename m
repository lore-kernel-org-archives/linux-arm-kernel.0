From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 09:53:45 -0800
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
In-Reply-To: <20131114174913.GJ11022@katana>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
 <20131114065830.GA2738@katana> <20131114173429.GF10317@atomide.com>
 <20131114174913.GJ11022@katana>
Message-ID: <20131114175344.GI10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa@the-dreams.de> [131114 09:49]:
> 
> > > It would have been helpful if the message "PATCH [0/x]" would have been
> > > sent to the i2c-list also.
> > 
> > Thanks, next time I'll try check the cc list in the cover letter
> > manually after running git format patch. I guess there's no way
> > to deal with that in an automated way.
> 
> I use this hackish script as --cc-cmd with git:
> 
> #! /bin/sh
> #
> # cocci_cc - send cover letter to all mailing lists referenced in a patch series
> # done by Wolfram Sang in 2012 - WTFPLv2
> 
> name=${1##*/}
> num=${name%%-*}
> 
> if [ "$num" = "0000" ]; then
> 	dir=${1%/*}
> 	for f in $dir/*; do
> 		patchname=${f##*/}
> 		[ "${patchname%%-*}" = "0000" ] && continue
> 		scripts/get_maintainer.pl --no-m $f
> 	done | sort -u
> else
> 	scripts/get_maintainer.pl $1
> fi
> 

Cool thanks :) I'll give it a try next time.

Tony
