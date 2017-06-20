From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 20 Jun 2017 14:10:11 +0200
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
Message-ID: <20170620121011.GA13221@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-06-20 12:03:48, Alexandre Belloni wrote:
> On 20/06/2017 at 11:35:08 +0200, Benjamin Gaignard wrote:
> > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > rely on 32bits variables and that will make rtc break in y2038/2016.
> 
> Please don't, because this hide the fact that the hardware will not
> handle dates in y2038 anyway and as pointed by Russell a few month ago,
> rtc_time_to_tm will be able to catch it but the 64 bit version will
> silently ignore it.

Reference? Because rtc on PCs stores date in binary coded decimal, so
it is likely to break in 2100, not 2038...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/429aeb11/attachment.sig>
