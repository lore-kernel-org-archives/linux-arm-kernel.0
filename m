From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 14 Jun 2013 20:19:50 +0800
Subject: [PATCH 1/3] usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
In-Reply-To: <87sj0khq5o.fsf@ashishki-desk.ger.corp.intel.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
 <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
 <87sj0khq5o.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAGsJ_4zH8f3TFZj=9JurzniKuooFKZny=6m=q7MsgTQqwKe=8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/14 Alexander Shishkin <alexander.shishkin@linux.intel.com>:
> Barry Song <21cnbao@gmail.com> writes:
>
>> +if USB_CHIPIDEA_UDC && USB_CHIPIDEA_HOST
>> +
>> +config USB_CHIPIDEA_SIRF
>> +     depends on ARCH_SIRF
>> +     bool "SiRF USB controller ChipIdea driver binding"
>> +     default y
>> +     help
>> +       Say Y here to enable sirf usb ChipIdea driver binding.
>> +
>> +config USB_CHIPIDEA_MSM
>> +     depends on ARCH_MSM
>> +     bool "MSM USB controller ChipIdea driver binding"
>> +     default y
>> +     help
>> +       Say Y here to enable msm usb ChipIdea driver binding.
>> +
>> +config USB_CHIPIDEA_IMX
>> +     depends on ARCH_MXC || ARCH_MXS
>> +     bool "i.MX USB controller ChipIdea driver binding"
>> +     default y
>> +     help
>> +       Say Y here to enable imx usb ChipIdea driver binding.
>> +
>> +endif
>
> No. This is wrong on at least 3 different levels.

the point is we don't directly include MSM, IMX, SiRF and all other
drivers once we enable chipidea. that makes these drivers optional,
not always be built-in.

-barry
