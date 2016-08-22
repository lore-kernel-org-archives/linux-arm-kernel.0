From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 12:51:41 -0600
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160822125458.GC17367@ulmo.ba.sec>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
 <94227d94-1d60-fda7-731b-26656633d585@nvidia.com>
 <20160822125458.GC17367@ulmo.ba.sec>
Message-ID: <889ad898-873f-ecba-ef22-3492d731c75a@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 06:54 AM, Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 10:26:50AM +0100, Jon Hunter wrote:
>>
>> On 19/08/16 18:32, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> The Boot and Power Management Processor (BPMP) is a co-processor found
>>> on Tegra SoCs. It is designed to handle the early stages of the boot
>>> process and offload power management tasks (such as clocks, resets,
>>> powergates, ...) as well as system control services.
>>>
>>> Compared to the ARM SCPI, the services provided by BPMP are message-
>>> based rather than method-based. The BPMP firmware driver provides the
>>> services to transmit data to and receive data from the BPMP. Users can
>>> also register an MRQ, for which a service routine will be run when a
>>> corresponding event is received from the firmware.
>>
>> MRQ?
>
> I think that means "Message ReQuest", which is sort of like an IRQ but
> the user will receive a message (with potentially payload) instead. Do
> you want me to spell that out in the commit message, or what would you
> suggest?

I believe MRQ refers to the ID/type/semantics of the message structure 
itself, not so much the notification aspect of having received a message.
