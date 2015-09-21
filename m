From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Mon, 21 Sep 2015 10:48:19 +0300
Subject: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
In-Reply-To: <87zj0rsqhe.fsf@belgarion.home>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
 <87zj0rsqhe.fsf@belgarion.home>
Message-ID: <55FFB643.1080208@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/12/2015 04:43 PM, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:
>
>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
>> build error here because it removed the type LPSS_SSP and I didn't notice
>> the type was used here too.
>>
>> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
>> accidentally by copying all enum pxa_ssp_type types from
>> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>>
>> Fix the build error by removing this incorrect binding.
>>
>> Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Reported-by: Axel Lin <axel.lin@ingics.com>
>> Cc: <stable@vger.kernel.org> # 4.2
>> ---
>> v2: Added Fixes tag suggested by Robert Jarzmik
>
> Queued into pxa/fixes, thanks.
>
Gentle reminder, is this going to 4.3-rc3?

-- 
Jarkko
