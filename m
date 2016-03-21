From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 21 Mar 2016 10:57:56 +0200
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
Message-ID: <56EFB794.5010505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On 03/19/16 21:38, Paul Walmsley wrote:
> On Fri, 18 Mar 2016, Peter Ujfalusi wrote:
> 
>> Hi,
>>
>> Chanes since v1:
>> - removed the ASoC patch as Mark has applied it already
>> - Added my signed-off to the hwmod patch
>> - New patch to handle the case when the sidetone hwmod has been removed for
>>   legacy boot.
>>
>> The series addresses a long standing issue with McBSP2/3 regarding to hwmod
>> setup. When booting with DT a warning is printed that mcbsp2/3 is using two
>> hwmod.
>> The root of the issue is the way how the hwmod data was constructed in the first
>> place for OMAP3 McBSP2/3.
>> After re-reading the TRM it is clear that the sidetone should not have it's
>> own hwmod data as it is not a separate IP, it is part of the McBSP module. It
>> can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bit is only
>> sets the autoidle from the internal McBSP_iclk clock to the sidetone block of
>> the same McBSP.
> 
> NAK, at least without further discussion - see my comments on the v1 0/3 
> introduction.

Yes, I could have sent the first series as RFC, but I believe(d) that this is
the correct way to fix the McBSP sidetone integration.

-- 
P?ter
