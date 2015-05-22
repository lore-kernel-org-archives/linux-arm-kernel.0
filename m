From: lho@apm.com (Loc Ho)
Date: Fri, 22 May 2015 11:25:06 -0700
Subject: [PATCH v10 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20150522084625.GE23022@pd.tnic>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
 <1431991481-25684-5-git-send-email-lho@apm.com>
 <4456746.y9FVaqRogk@wuerfel> <20150522084625.GE23022@pd.tnic>
Message-ID: <CAPw-ZT=j-71csrKgpk=B47=JBH7Jrmmsu5_JeemaZRcGJO_eTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> > +static int edac_mc_idx;
>> > +static int edac_mc_active_mask;
>> > +static int edac_mc_registered_mask;
>> > +static DEFINE_MUTEX(xgene_edac_mc_lock);
>>
>> It would also be best to avoid global variables, but it seems that at
>> least the edac_mc_idx is needed to work with the EDAC subsystem.
>> Maybe Boris has an idea for how to avoid it.
>
> Right, so AFAICT this is used in
>
>         edac_mc_alloc(edac_mc_idx++
>
> and basically we're supplying the memory controller numbers in the order
> we're calling xgene_edac_mc_add(). Perhaps we need to make the memory
> controller numbering explicit with DT...
>

Let me move them all into the top level driver given that the MC is
now a subnode.

-Loc
