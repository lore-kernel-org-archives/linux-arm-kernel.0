From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 10 Sep 2014 09:55:48 +0800
Subject: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <CAErSpo4cAfom2=07NYDRfTCdHO22M0v+ueiaZuG6v2Xd18wEnQ@mail.gmail.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-8-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJi8k1Goc3UmXhuxf9v7=4gJrYG_Di7v574PxS8TsJaXw@mail.gmail.com>
 <20140908145459.GO27864@e106497-lin.cambridge.arm.com>
 <CAL_JsqJdGKDVwJOpPp19OkVPGzR7Zqv3nh+ONHHaYnPLYTYoYg@mail.gmail.com>
 <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
 <540E960D.7080408@huawei.com>
 <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
 <540EC8CB.7010106@huawei.com>
 <CAErSpo4cAfom2=07NYDRfTCdHO22M0v+ueiaZuG6v2Xd18wEnQ@mail.gmail.com>
Message-ID: <540FAFA4.1080008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> OK. Sorry, I have one last question, because domain will be used to calculate the address used to
>> access PCI hardware config registers. So if DTS file doesn't report the domain, how do we know
>> we would access the right registers when we use the auto increment domain vaule ?
>> Has there a mechanism to make sure system can access the correct registers by the domain ?
> 
> I think you're referring to config access via ECAM (PCIe r3.0, sec
> 7.2.2).  In that case, I don't think the domain should be used to
> compute the memory-mapped configuration address.  Each host bridge is
> in exactly one domain, and each host bridge has an associated ECAM
> area base.  The address calculation uses the bus number, device
> number, function number, and register number to compute an offset into
> the ECAM area.
> 
> So as long as the DT tells you the ECAM information for each host
> bridge, that should be sufficient.  The domain number is then just a
> Linux convenience and is not tied to the platform as it is on ia64.

Hi Bjorn, you are right, thanks for your detailed explanation! :)

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
