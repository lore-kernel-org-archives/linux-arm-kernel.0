From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Mon, 12 Dec 2011 13:22:28 +0200
Subject: [PATCH] ARM: OMAP: mcbsp: Fix possible memory corruption
In-Reply-To: <4EE5D639.8080608@compulab.co.il>
References: <1323678976-4119-1-git-send-email-jarkko.nikula@bitmer.com>
 <1323679106-4191-1-git-send-email-jarkko.nikula@bitmer.com>
 <4EE5D639.8080608@compulab.co.il>
Message-ID: <4EE5E3F4.6060701@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 12/12/2011 12:23 PM, Igor Grinberg wrote:
> On 12/12/11 10:38, Jarkko Nikula wrote:
>> Commits 09d28d ("ARM: OMAP: mcbsp: Start generalize omap2_mcbsp_set_clks_src")
>> and 7bc0c4 ("ARM: OMAP: mcbsp: Start generalize signal muxing functions")
>> incorrectly set two struct omap_mcbsp_platform_data fields after
>> omap_device_build_ss and kfree calls.
>>
>> Fix this by moving these pdata assignments before those calls.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>> Reported-by: neilb at suse.de
> Perhaps, should be:
> Reported-by: NeilBrown <neilb@suse.de>
> and
> Cc: <stable@vger.kernel.org>	[3.1]
> as for below.
>> ---
>> For 3.2, 3.1 is ok.
>> ---
No need to cc stable since the issue is not in stable kernels.

-- 
Jarkko
