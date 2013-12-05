From: pekon@ti.com (Gupta, Pekon)
Date: Thu, 5 Dec 2013 05:43:05 +0000
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529FE81C.4000608@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA51905@DBDE04.ent.ti.com>
 <529EE5F1.9080806@st.com> <201312041636.20875.marex@denx.de>
 <529FE81C.4000608@freescale.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA51E1A@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Huang Shijie [mailto:b32955 at freescale.com]
>
>>? 2013?12?04? 23:36, Marek Vasut ??:
>> I disagree we should bloat the API with features, that will be used by "possible
>> future controllers" or "possible single controller", right from the start. The
>> real question here is, can the API be designed in such a way, that the SR
>> polling will happen in software NOW and only when a controller appears that can
>> do polling in HW will the API be extended to support it ?
>ok. Let's add this feature in the future when a real case occurs.
>
Sorry got lost.. Can you please summarize following plans for your next patch:

(1) Polling of status registers should be 
  (a) done in S/W (generic driver)
  (b) done controller driver, which can be optimized for specific hardware

(2) How do you plan to have timeout value, (as serial flash can be pretty slow
   to access) ?
  (a) independent for each access
       - read timeouts per sector, which can be multiplied with read_len/sector_size
       - write timeout per sector, which can be multiplied with write_len/sector_size
       - erase timeout per block, which can be multiplied with erase_len/block_size
  (b) Any other method, or leave it to controller driver ?

In my view, before proceeding to writing down a patch, I think
we should come-up with a doc/Readme, which defines all API and interface
structs (taking Angus' proposal as baseline). And then refine that spec first.
Otherwise there may be too many revisions spent on patch RFC's .. 

Any thoughts ?
And is there a space in kernel_docs for such specs ?

With regards, pekon
