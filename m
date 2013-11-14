From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Nov 2013 18:49:13 +0100
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
In-Reply-To: <20131114173429.GF10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
 <20131114065830.GA2738@katana> <20131114173429.GF10317@atomide.com>
Message-ID: <20131114174913.GJ11022@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > It would have been helpful if the message "PATCH [0/x]" would have been
> > sent to the i2c-list also.
> 
> Thanks, next time I'll try check the cc list in the cover letter
> manually after running git format patch. I guess there's no way
> to deal with that in an automated way.

I use this hackish script as --cc-cmd with git:

#! /bin/sh
#
# cocci_cc - send cover letter to all mailing lists referenced in a patch series
# done by Wolfram Sang in 2012 - WTFPLv2

name=${1##*/}
num=${name%%-*}

if [ "$num" = "0000" ]; then
	dir=${1%/*}
	for f in $dir/*; do
		patchname=${f##*/}
		[ "${patchname%%-*}" = "0000" ] && continue
		scripts/get_maintainer.pl --no-m $f
	done | sort -u
else
	scripts/get_maintainer.pl $1
fi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/147fd74a/attachment-0001.sig>
