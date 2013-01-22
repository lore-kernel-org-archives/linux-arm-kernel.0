From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 22 Jan 2013 13:50:15 +0100
Subject: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
 (Vaibhav Bedia's message of "Mon, 21 Jan 2013 10:37:06 +0000")
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <87ip6vlwaf.fsf@dell.be.48ers.dk>
 <B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
Message-ID: <87sj5t4c1k.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "V" == Bedia, Vaibhav <vaibhav.bedia@ti.com> writes:

Hi,

 V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);
 >> 
 >> A size check would be good. I don't know much about the finer details
 >> about the m3 and how it is connected, but don't you need to ensure data
 >> is flushed before resetting the m3?
 >> 

 V> Will add the reg property in the next version. The wkup-m3 memory is
 V> coming via ioremap() so AFAIK it should be ok. I realized that I do
 V> need to replace the memcpy() with memcpy_toio() here.

Ok, thanks.

-- 
Bye, Peter Korsgaard
