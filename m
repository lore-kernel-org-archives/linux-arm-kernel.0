From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jan 2014 10:35:22 +0000
Subject: About Mail-Followup-To and Mutt [Was: Re: [ARM] Fix kernel
 compile error: drivers/crypto/ixp4xx_crypto.c]
In-Reply-To: <20140102084252.GF10158@pengutronix.de>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
 <20131231181427.GE16456@n2100.arm.linux.org.uk>
 <20140101121822.GA20094@book.gsilab.sittig.org>
 <20140102084252.GF10158@pengutronix.de>
Message-ID: <20140102103522.GH16456@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 09:42:52AM +0100, Uwe Kleine-K?nig wrote:
> I have
> 
> 	# set followup_to = yes
> 
> in my .mutt/muttrc---so I'm using the default---but I'm still
> unaffected. I think this is because I don't have any lists specified
> (using the lists and subscribe commands). And note that there are lists
> that consider using MFT to be good, ISTR that it applies to
> *@lists.debian.org, but cannot currently find a reference to support
> that claim. The problem is that using MFT only works if all recipents
> are using and respecting it.

Your last statement is total rubbish.  This header is seen by the
mainstream Linux community as being totally evil.

> If Russell is annoyed in general by MFT, he could unset
> honor_followup_to.

And how does that stop the problem when someone *else* replies to the
message with a Mail-Followup-To?  FYI, I was hounded off LKML for having
that header set.

When people have this header set, and people reply to such a message, all
recipients get moved into the To: header.  This makes it impossible on
high traffic lists for people to prioritise their reading of messages
according to whether they're in the To: header or just in the Cc: header.

Being in the To: header means that someone is directing the message *AT*
you and wanting *YOU* to do something with it.  Being in the Cc: is more
"for information" and so takes a lower priority.

Hence, when someone replies to a message, and their mail client ends up
moving all recipients into the To: header, it completely destroys the
ability to prioritise the reading.  So, either we adopt the same position
here as the rest of the Linux community wrt this header, or I'm just going
to read messages on the list at random, completely ignoring whether I'm
in the To: header or not.

What that means is that there will have *no way* to attract my attention
to any email message - since I will not care one bit whether I'm listed
me in the To: header or not.

And no, you are NOT going to pester me on IRC each time.

--
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
