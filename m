From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 04 Nov 2014 00:16:41 +0100
Subject: [PATCH v2] ARM: BCM5301X: set customized AUXCTL
In-Reply-To: <64693192.oy48jMW2b1@wuerfel>
References: <1414851912-30630-1-git-send-email-hauke@hauke-m.de>
 <1414852899-30947-1-git-send-email-hauke@hauke-m.de>
 <64693192.oy48jMW2b1@wuerfel>
Message-ID: <54580CD9.3050309@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 11:00 AM, Arnd Bergmann wrote:
> On Saturday 01 November 2014 15:41:38 Hauke Mehrtens wrote:
>>  };
>>  
>>  DT_MACHINE_START(BCM5301X, "BCM5301X")
>> -       .l2c_aux_val    = 0,
>> +       .l2c_aux_val    = L310_AUX_CTRL_CACHE_REPLACE_RR |
>> +                         L310_AUX_CTRL_DATA_PREFETCH |
>> +                         L310_AUX_CTRL_INSTR_PREFETCH |
>> +                         L310_AUX_CTRL_EARLY_BRESP,
> 
> Please put these into the dts file instead if the boot loader fails
> to set them correctly. We should not override them from source code
> for new platforms any more.
I checked again and I only need L310_AUX_CTRL_DATA_PREFETCH and
L310_AUX_CTRL_INSTR_PREFETCH, the others get activate by the existing
code. Should I make it possible to give l2c_aux_val through dt, or
should I create some boolean options for  L310_AUX_CTRL_DATA_PREFETCH
and  L310_AUX_CTRL_INSTR_PREFETCH?

Hauke
