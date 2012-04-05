From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 05 Apr 2012 11:16:22 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1333497309.20733.YahooMailClassic@web29019.mail.ird.yahoo.com>
References: <1333497309.20733.YahooMailClassic@web29019.mail.ird.yahoo.com>
Message-ID: <4F7D54D6.70206@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 04/04/12 02:55, Paul Parsons wrote:
> Hello Igor,
> 
> --- On Tue, 3/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Please, check the attached patch.
>> It should not change the meaning of KEEP_OUTPUT, but fix the
>> bug.
> 
> Yes, your patch - pxa2xx-mfp.patch - does fix the KEEP_OUTPUT bug.

Looking at it one more time, we setup the GPDR with values from gpdr_lpm,
and afterwards we setup them once again to update for KEEP_CONFIG.
This can introduce a kind of spike on the GPIO (depending on how fast
the system runs).
So, fixed patch attached. Can you please test it once more and I will
submit it properly?


-- 
Regards,
Igor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pxa2xx-mfp.patch
Type: text/x-patch
Size: 817 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120405/abeb7b52/attachment.bin>
