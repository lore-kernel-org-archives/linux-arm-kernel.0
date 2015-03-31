From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 31 Mar 2015 17:33:23 +0200
Subject: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
In-Reply-To: <20150331152958.GF9974@htj.duckdns.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-4-git-send-email-peter.griffin@linaro.org>
 <20150331152958.GF9974@htj.duckdns.org>
Message-ID: <551ABE43.60602@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tejun,

On 03/31/2015 05:29 PM, Tejun Heo wrote:
> On Tue, Mar 31, 2015 at 08:35:09AM +0100, Peter Griffin wrote:
>> Currently the ahci_st driver will hang the system on probe, as the
>> st_configure_oob function does some register writes before the IP
>> is clocked. This patch moves the function call to after
>> ahci_platform_enable_resources (which enables the IP clock), and
>> resolves the hang.
>>
>> Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
>> function, so we also rectify that ensuring it is also called after
>> the IP clock has been enabled.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> How should this patch be routed?  Should I pick this up and apply to
> libata/for-4.1 or should it go together with the other patches?  If
> the latter, please feel free to add my acked-by.

I think you can pick patches 1 & 3.
I will apply patch 2 to STi DT branch.

Thanks,
Maxime
>
> Thanks.
>
