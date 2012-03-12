From: scottwood@freescale.com (Scott Wood)
Date: Mon, 12 Mar 2012 14:39:06 -0500
Subject: [PATCH 1/1] of: introduce helper to manage boolean
In-Reply-To: <20120309163608.GQ27213@game.jcrosoft.org>
References: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
 <20120309014441.8236B3E0903@localhost>
 <20120309100435.GN27213@game.jcrosoft.org>
 <20120309162638.92E813E0880@localhost>
 <20120309163608.GQ27213@game.jcrosoft.org>
Message-ID: <4F5E50DA.6080000@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2012 10:36 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>> Ugh.  so any value other than 1 returns false?  I think that will surprise
>>>> most people.
>>>>
>>>> I don't like this api or binding.  If it is a bool property, then why isn't
>>>> simply testing for the property existance sufficient?
>>> no if you want to disable it
>>>
>>> if a bool is define in the dtsi and want to disable it int the dts
>>>
>>> if you we can do the the invert
>>>
>>> if !0 => true
>>>
>>> is-ok;			=> true
>>> is-ok = <val != 0>;	=> true
>>> is-ok = <0>;		=> false
>>
>> This is a failure of the dtc tool, not the binding.  Accepting this binding
>> means we have to live with it for a very long time.  It needs to be fixed
>> in dtc instead so that properties can be deleted instead of only modified.
> I understand your idea but today if you put and value in the property it's true.
> 
> So is-ok = <0>; is true also which is illogical as in any language a boolean is
> true (1) or false (0). When I read the property I will understand false not true

You could say similar things about is-ok = "no" or is-ok = "" or is-ok =
"I'd rather you didn't"... it's expected that violating the binding may
produce illogical results.

> And I see no good way to add the "delete" in dtc.

It shouldn't be that hard, just needs a new keyword and/or bit of syntax
to express what you want it to do.

-Scott
