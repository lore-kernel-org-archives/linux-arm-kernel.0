From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Mar 2018 17:51:02 +0000
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
 <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
 <ec84d8ee-8b90-5365-5be4-4b08d274c6e5@nokia.com>
Message-ID: <CAKv+Gu8WeV+7U4omoMvECPa0LhF4Nrusvy+V0mirWVfejCebNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2018 at 17:49, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> On 13/03/18 18:39, Ard Biesheuvel wrote:
>> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>>     module_plt_alloc_fixed();
>
> Do you consider this a legal C code if without module-plts.o the function would not exist at all?
> That's too much relying on optimizer I think...
>

Yes, we rely on that in many different places in the kernel.
