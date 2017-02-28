From: yannick.fertre@st.com (Yannick FERTRE)
Date: Tue, 28 Feb 2017 10:07:22 +0000
Subject: [PATCH v2 4/9] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <CAL_JsqLqNzpV1pjz3bX1gowHwJzsKKA=17aD5Ce18sy1B_V-0g@mail.gmail.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
 <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
 <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
 <2b409ff7-54fe-4110-6495-1cc54585e5e2@st.com>
 <CAL_JsqLBZ0DGP62yGb2GjNZMto9hWce_HWNCX5iWhbrnE3ae_Q@mail.gmail.com>
 <0036d551-91bc-9f3f-22a9-9dac2cf3527c@st.com>
 <CAL_JsqLqNzpV1pjz3bX1gowHwJzsKKA=17aD5Ce18sy1B_V-0g@mail.gmail.com>
Message-ID: <c759770a-f250-7502-4ad1-c2fbb001cf92@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/24/2017 03:06 PM, Rob Herring wrote:
> On Fri, Feb 24, 2017 at 2:18 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
>>
>>
>> On 02/21/2017 03:07 PM, Rob Herring wrote:
>>> On Mon, Feb 20, 2017 at 5:01 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
>>>>
>>>>
>>>> On 02/16/2017 03:34 AM, Rob Herring wrote:
>>>>> On Fri, Feb 10, 2017 at 03:54:44PM +0100, Yannick Fertre wrote:
>>>>>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
>>>>>> ---
>>>>>>  .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..f59e3c4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>>>>> @@ -0,0 +1,7 @@
>>>>>> +Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: should be "ampire,am-480272h3tmqw-t01h"
>>>>>
>>>>> No GPIO controls or power supply for this panel?
>>>>>
>>>>> Rob
>>>>>
>>>>
>>>> Hi Rob,
>>>> thank for your reply.
>>>> There is no gpio or power supply control for this panel with the eval
>>>> board stm429x9i.
>>>
>>> You need to describe what the panel has, not what you have control of
>>> or not on a particular board.
>>
>> Yes, I don't have to describe control on a particular board. This
>> binding contains few lines. This compatible is used by panel-simple to
>> get only timings. Other staff like gpio or power-suypply is well managed
>> by panel-simple itself.
>>
>> This binding is similar to these bindings & not required more details:
>
> Finding bad examples is not an argument. And yes, lots went in before
> we started being more particular in reviews, but now I want to see
> power supplies and control lines accurately described. Next week,
> there may be additional requirements.
>
> This is no different than clock or interrupt bindings. We don't just
> say "uses clock/interrupt binding" in binding docs. You have to
> explicitly state how many clocks/interrupts and their order.
>
>
>>    -ampire,am-480272h3tmqw-t01h.txt,ampire,am800480r3tmqwa1h.txt,
>>    -auo,b080uan01.txt,auo,b101aw03.txt,auo,b101ean01.txt,
>>    -auo,b101xtn01.txt,auo,b116xw03.txt,auo,b133htn01.txt,
>>    -auo,b133xtn01.txt,auo,g133han01.txt,auo,g185han01.txt,
>>    -auo,t215hvn01.txt,avic,tm070ddh03.txt,
>>    -boe,tv080wum-nl0.txt,chunghwa,claa070wp03xg.txt,
>>    -chunghwa,claa101wa01a.txt,chunghwa,claa101wb03.txt,
>>    -edt,et057090dhu.txt,edt,et070080dh6.txt,edt,etm0700g0dh6.txt,
>>    -foxlink,fl500wvr00-a0t.txt,giantplus,gpg482739qs5.txt,
>>    -hannstar,hsd070pww1.txt,hannstar,hsd100pxn1.txt,
>>    -hit,tx23d38vm0caa.txt,innolux,at043tn24.txt,
>>    -innolux,at070tn92.txt,innolux,g101ice-l01.txt,
>>    -innolux,g121i1-l01.txt,innolux,g121x1-l03.txt,
>>    -innolux,n116bge.txt,innolux,n156bge-l21.txt,
>>    -innolux,zj070na-01p.txt,kyo,tcg121xglp.txt,
>>    -lg,lb070wv8.txt,lg,ld070wx3-sl01.txt,lg,lh500wx1-sd03.txt,
>>    -lg,lp079qx1-sp0v.txt, lg,lp097qx1-spa1.txt,lg,lp120up1.txt,
>>    -lg,lp129qe.txt, nec,nl4827hc19-05b.txt,
>>    -nvd,9128.txt,okaya,rs800480t-7x0gp.txt,
>>    -olimex,lcd-olinuxino-43-ts.txt,ontat,yx700wv03.txt,
>>    -ortustech,com43h4m85ulc.txt, panasonic,vvx10f004b00.txt,
>>    -qiaodian,qd43003c0-40.txt,
>>    -samsung,lsn122dl01-c01.txt,samsung,ltn101nt05.txt,
>>    -samsung,ltn140at29-301.txt,sharp,lq101k1ly04.txt,
>>    -sharp,lq123p1jx31.txt,
>>    -shelly,sca07010-bfn-lnn.txt,starry,kr122ea0sra.txt,
>>    -tpk,f07a-0102.txt,tpk,f10a-0102.txt,urt,umsh-8596md.txt
>>
>> Best regards
>>
>>>
>>>> This binding is similar to all panel bindings which are link to panel
>>>> simple. Details on gpio & power supply are describe with simple-panel
>>>> binding.
>>>
>>> simple-panel.txt provides what possible standard properties there are,
>>> not whether a panel uses them. The power supply needs to be explicit
>>> because I don't know if you forgot and there's really 2 supplies or
>>> you are using "power-supply" for a single supply.
>>>
>>> Rob
>>>


Hi Rob,
ok, I'll push a V4 version with all details on properties.
I write bellow  a draft of binding:

Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel

This binding is compatible with the simple-panel binding, which is specified
in simple-panel.txt in this directory.

Required properties:
- compatible: should be "ampire,am-480272h3tmqw-t01h"

Optional properties:
- power-supply: regulator to provide the supply voltage
- ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
- enable-gpios: GPIO pin to enable or disable the panel
- backlight: phandle of the backlight device attached to the panel

Optional nodes:
- Video port for RGB input.

Example:
	panel_rgb: panel-rgb {
		compatible = "ampire,am-480272h3tmqw-t01h";
		enable-gpios = <&gpioa 8 1>;
		port {
			panel_in_rgb: endpoint {
				remote-endpoint = <&controler_out_rgb>;
			};
		};
	};

Best regards
