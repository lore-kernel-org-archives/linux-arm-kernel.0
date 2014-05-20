From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 May 2014 15:10:44 -0700
Subject: [PATCH v4 6/6] ARM: dts: STiH407: Add B2120 board support
In-Reply-To: <20140520074353.GD20874@lee--X1>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-7-git-send-email-maxime.coquelin@st.com>
 <CAOesGMg5Jk_XB3zdfKz8VxRObYbFO8OMuRyo7Ba-kavANbci1w@mail.gmail.com>
 <20140520072048.GC20874@lee--X1>
 <CAOesGMioLwX3jgGEsR=rHV0u6yR54b4x8BfyZ91vjJnMapUHew@mail.gmail.com>
 <20140520074353.GD20874@lee--X1>
Message-ID: <CAOesGMigF7CGtTmLMW4zbRemGaMbWs6NV6KLPFZQFYmnHc=HQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 12:43 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> > +       soc {
>> >> > +               sbc_serial0: serial at 9530000 {
>> >> > +                       status = "okay";
>> >> > +               };
>> >>
>> >> You might want to consider reference-based syntax here instead, so you
>> >> don't have to mimic the hierarchy. That'd be (at the root level of the
>> >> file, below this secion:
>> >>
>> >> &sbc_serial0: {
>> >>         status = "okay";
>> >> };
>> >
>> > I'm personally not keen on this scheme.  It's sometimes helpful to know
>> > the hierarchy and I don't think it's a large overhead to format the
>> > subordinate DTS files in this way.
>> >
>> > Please consider not enforcing this.
>>
>> Definitely not enforcing it, and I didn't use to like it either but it
>> has some real upsides.
>>
>> In particular, it saves a lot of grief when you're changing something
>> like the unit-id of a node in .dtsi and forget to do the same update
>> in the dts.
>
> I'm not entirely sure what a unit-id is, but I can see that there
> would be benefits to using the referenced-based syntax as you call
> it.  If any of those benefits hold true here I won't push back, but I
> would personally like to see us default to the hierarchical scheme.

Sorry, I meant unit-address. I.e. the portion that goes behind the @
in the node name.


-Olof
