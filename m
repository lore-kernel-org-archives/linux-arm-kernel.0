From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 22:19:25 +0100
Subject: [PATCH 1/8] i2c: mux-pinctrl: Rework to honor disabled child nodes
In-Reply-To: <54E3AF5F.3020902@wwwdotorg.org>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <54E3A8A7.8080703@wwwdotorg.org> <54E3ADB9.1040008@gmail.com>
 <54E3AF5F.3020902@wwwdotorg.org>
Message-ID: <54E3B05D.5050805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2015 22:15, Stephen Warren wrote:
> On 02/17/2015 02:08 PM, Sebastian Hesselbarth wrote:
>> On 17.02.2015 21:46, Stephen Warren wrote:
>>> Can you be more explicit about the problem here? Why does anything need
>>> to be re-written if a child node is disabled; presumably there's no need
>>> for the child bus numbers to be contiguous. In other words, with the
>>> example in the existing DT binding doc:
[...]
>>
>> The way the current driver works, to disable i2c at 0 you'd have to remove
>> the pinctrl-0 state, pinctrl-names string at position 0, and the node
>> itself.
[...]
> OK, that all makes sense, but I don't think there's any change at all to
> the binding; this can all be fixed in the driver without affecting the
> definition of the binding at all. At most all that's needed in the
> binding is a note to the effect that if a particular child node is
> disabled, then this has no effect at all on the requirements for the
> pinctrl properties.

I totally agree that the binding is not affected at all. I was under the
impression that the current binding doc justifies the way the driver is
currently parsing the properties. So this was an attempt to reword it
to make it more clear what properties should influence the way
sub-busses are registered.

I'll have another look at the binding doc when the driver is fine.

[...]
>> Do you still have one of the current boards available for testing?
>
> Yes, I have both Seaboard and Ventana still (the two Tegra boards that
> use this driver). I haven't used them in a while; I hope they still work:-)

Ok, I cross my fingers too and expect a Tested-by :)

Sebastian
