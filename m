From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 11:56:36 +0200
Subject: [PATCH/RFT v2 13/17] USB: da8xx: use ohci priv data instead of
 globals
In-Reply-To: <0cf6f211-90ba-2f7b-978f-f1cfa1b11554@lechnology.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-14-ahaslam@baylibre.com>
 <0cf6f211-90ba-2f7b-978f-f1cfa1b11554@lechnology.com>
Message-ID: <CAKXjFTNma7RLK2fwch33aVL1ULE1jrNEN4PF=JWZW-sVtcs-dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 3:12 AM, David Lechner <david@lechnology.com> wrote:
> On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
>>
>> From: Axel Haslam <ahaslam@baylibre.com>
>> >  static const struct ohci_driver_overrides da8xx_overrides __initconst =
>> > {
>> -       .reset          = ohci_da8xx_reset
>> +       .reset          = ohci_da8xx_reset,
>> +       .extra_priv_size = sizeof(struct da8xx_ohci_hcd),
>
>
> nit: since you are changing both lines anyway, you might as well make the
> ='s line up.

ok, will do.

>
>>  };
>>
>>  /*
>>
>
