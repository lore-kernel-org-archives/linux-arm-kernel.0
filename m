From: rbthomas@pobox.com (Rick Thomas)
Date: Mon, 25 Jan 2016 19:50:55 -0800
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
In-Reply-To: <20160125182459.GE15550@darkstar.musicnaut.iki.fi>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
 <20160124173701.GU3880@lunn.ch>
 <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com>
 <20160124214020.GA28667@jirafa.cyrius.com>
 <8E11A1EE-D73B-462E-A493-39571A17F2C3@pobox.com>
 <20160125182459.GE15550@darkstar.musicnaut.iki.fi>
Message-ID: <B9F504A1-867C-4B99-98CF-8EDE3A0BEB38@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 25, 2016, at 10:24 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> 
> On my board I need to say "amixer set PCM on". Can you post the full
> output from "amixer" without any parameters?
> 
> Also check if you have this line in dmesg:
> 
> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
> 
> If it says "spdif" the player runs but is silent.
> 
> A.
> 

Here's the output of "amixer"

-------------- next part --------------
A non-text attachment was scrubbed...
Name: amixer.out
Type: application/octet-stream
Size: 2059 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/825c4c7d/attachment.obj>
-------------- next part --------------


This is after having run alsamixer (per Martin's suggestion) and un-mute-ing everything I could find.

And here's the output of "dmesg"

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.out
Type: application/octet-stream
Size: 18738 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/825c4c7d/attachment-0001.obj>
-------------- next part --------------


In particular

> rbthomas at base:~$ dmesg | grep sound    
> [   11.777850] asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok

Everything is working fine now.

Thanks for all the help!
Rick
