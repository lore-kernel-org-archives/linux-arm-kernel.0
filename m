From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 3 Jul 2018 10:44:13 +0100
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
 <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Message-ID: <79d24815-278a-5465-65eb-afd3535236e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 14/06/18 14:59, Rob Herring wrote:
> On Thu, Jun 14, 2018 at 2:53 AM, Suzuki K Poulose
> <Suzuki.Poulose@arm.com> wrote:
>> On 13/06/18 22:07, Matt Sealey wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>
>>>>> So, if the suggestion is to use an existing property "unit", I am fine
>>>>> with it, if people agree to it.
>>>>
>>>>
>>>> If we're going to have something sharply different than ACPI I prefer
>>>> Rob's idea.
>>
>>
>> No, the above comment is about using "unit" ( if it is a standard property
>> for specifying something specific to hardware) instead of "coresight,hwid".
>> I would prefer to stick to the DT graph bindings, because :
> 
> "unit" is not a standard property and I don't like it either.
> 
>>
>> 1) The connections are bi-directional => Well, not necessarily
>> bi-directional
>> in terms of the data flow. But the connection information is critical. i.e,
>> we need information about both the end-points of a connection, which the DT
>> graph bindings solves.
>>
>> All we are missing is a way for specifying the "hardware port" number and
>> the
>> direction of flow. I don't see why do we need to create something new just
>> for
>> these two properties for something that exists today and works reasonably
>> well
>> for the usecase.
> 
> If you have "in-ports" and "out-ports" nodes, then that gives you
> direction and you can use reg for the "hardware port".
> 
> in-ports {
>    port at 0 {
>      reg = <0>;
>      endpoint {...};
>    };
>    port at 1 {
>      reg = <1>;
>      endpoint {...};
>    };
> };
> out-ports {
>    port at 0 {
>      reg = <0>;
>      endpoint {...};
>    };
> };
> 
> I'll need to check, but dtc may need an update to not warn about this.
> 

I did a quick check with the upstream dtc tool and the above form is
doesn't generate any errors.

Mathieu, Rob,

Shall I proceed with the proposal above ?


Suzuki
