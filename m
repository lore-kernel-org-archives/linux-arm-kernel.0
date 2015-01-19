From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 19 Jan 2015 16:00:11 +0100
Subject: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
In-Reply-To: <1421396295.11671.50.camel@mtksdaap41>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421396295.11671.50.camel@mtksdaap41>
Message-ID: <20150119150010.GA3820@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> This can describe the behavior of our current upstream driver[1], which
> only support combine write-then-read.
> 
> After checking with Xudong & HW guys, it seems our HW can do more. 
> On MT8135, it can support at most 2 messages, no matter read or write,
> with the limitation that the length of the second message must <=
> 31bytes.
> 
> So this RFC is enough for our driver, but it would be better if we could
> also support other case.

Hmm, I think we can convert max_comb_{read|write}_len to
max_comb_{1st|2nd}_msg_len or similar.

I'll check but it will probably not before next week.

Thanks for the input!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/033f350b/attachment.sig>
