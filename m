From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 13 Apr 2017 13:15:54 +0100
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170404092604.GB14898@arm.com>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org> <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org> <20170404092604.GB14898@arm.com>
Message-ID: <1492085754.20068.2.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-04 at 10:26 +0100, Will Deacon wrote:
> ?A
> patch making arm64 consistent could be discussed separately, otherwise kdump
> becomes the pedantic ISO guy trying to lead by example, but really everybody
> ignores him because it's completely inconsequential and they also know he
> went 35 versions without giving a monkey's.

I still don't see the logic there for *wanting* kdump to be wrong.

Sure, kdump getting it right doesn't necessarily make a big difference
in?itself.

But given that the error has been pointed out, what is the motivation
for *wanting* the error to remain in the kdump code, instead of just
fixing it? "Consistency" isn't an answer because we are *already*
inconsistent ? some code gets it right, and other code doesn't.

We should converge towards *correctness* rather than deliberately
adding more incorrect code.

I've used my 'i' key more times just in?typing this email than it would
have taken to just fix the problem the first time it was pointed out.

> David, since you seem to be the most outraged, fancy sending a patch? ;)

Coming up. In two parts ? user-visible messages, followed by cosmetic
and less relevant stuff.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/3273313d/attachment.bin>
