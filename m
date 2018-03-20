From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 20 Mar 2018 11:17:21 +0100
Subject: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
In-Reply-To: <20180320095242.tedafu5wphsx55qx@katana>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
 <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
 <20180320095242.tedafu5wphsx55qx@katana>
Message-ID: <c7fa1cc2-a298-967c-6006-942fd631b4f0@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/20/2018 10:52 AM, Wolfram Sang wrote:
> 
>> I do believe the hw can support it, even it looks odd to me having the same I2C
>> in slave and master mode at the same time.
> 
> I2C is multi-master, so it is perfectly valid for a device to be master
> and slave. I do have seen designs making use of that more than once.
> 
>> Nevertheless the driver is devised to support either master or slave more but
>> not at the same time.
> 
> Why should we limit ourselves here? Also, why should we have an
> unnecessary configuration option?
> 
> Unless the HW is broken and does not support it, I usually don't accept
> slave-only solutions. If the needs for master and slave arises later,
> this is hard to refactor and better done properly right away.
> 
> Is it so hard? Usually you have irqs for master and for slave seperated,
> so you can code things quite orthogonal. Check de20d1857dd6 ("i2c: rcar:
> add slave support") as an example.
> 

I need to check at my end but status bits are shared between master and slave in
my IP: i.e. Tx Empty, Rx Empty, NAxk, Stop.
Both bits have a meaning in either master and slave mode. In your case status
bits are separated between master and slave.
BTW I need to think about it.
