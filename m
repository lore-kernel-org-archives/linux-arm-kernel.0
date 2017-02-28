From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 08:33:40 -0600
Subject: [PATCH v2 4/9] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <c759770a-f250-7502-4ad1-c2fbb001cf92@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
 <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
 <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
 <2b409ff7-54fe-4110-6495-1cc54585e5e2@st.com>
 <CAL_JsqLBZ0DGP62yGb2GjNZMto9hWce_HWNCX5iWhbrnE3ae_Q@mail.gmail.com>
 <0036d551-91bc-9f3f-22a9-9dac2cf3527c@st.com>
 <CAL_JsqLqNzpV1pjz3bX1gowHwJzsKKA=17aD5Ce18sy1B_V-0g@mail.gmail.com>
 <c759770a-f250-7502-4ad1-c2fbb001cf92@st.com>
Message-ID: <CAL_Jsq+PO_KT-UY2QdX1a5pvEYJv_E6kyamthXS=hE-jjR0XKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 4:07 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
> On 02/24/2017 03:06 PM, Rob Herring wrote:
>> On Fri, Feb 24, 2017 at 2:18 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
>>> On 02/21/2017 03:07 PM, Rob Herring wrote:
>>>> On Mon, Feb 20, 2017 at 5:01 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
>>>>> On 02/16/2017 03:34 AM, Rob Herring wrote:
>>>>>> On Fri, Feb 10, 2017 at 03:54:44PM +0100, Yannick Fertre wrote:
>>>>>>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
>>>>>>> ---
>>>>>>>  .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt

[...]

>>>>> This binding is similar to all panel bindings which are link to panel
>>>>> simple. Details on gpio & power supply are describe with simple-panel
>>>>> binding.
>>>>
>>>> simple-panel.txt provides what possible standard properties there are,
>>>> not whether a panel uses them. The power supply needs to be explicit
>>>> because I don't know if you forgot and there's really 2 supplies or
>>>> you are using "power-supply" for a single supply.
>>>>
>>>> Rob
>>>>
>
>
> Hi Rob,
> ok, I'll push a V4 version with all details on properties.
> I write bellow  a draft of binding:
>
> Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
>
> This binding is compatible with the simple-panel binding, which is specified
> in simple-panel.txt in this directory.
>
> Required properties:
> - compatible: should be "ampire,am-480272h3tmqw-t01h"
>
> Optional properties:
> - power-supply: regulator to provide the supply voltage
> - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing

Doesn't look like there's any DDC connection to this panel.

> - enable-gpios: GPIO pin to enable or disable the panel

Need to state this is active high.

> - backlight: phandle of the backlight device attached to the panel
>
> Optional nodes:
> - Video port for RGB input.
>
> Example:
>         panel_rgb: panel-rgb {
>                 compatible = "ampire,am-480272h3tmqw-t01h";
>                 enable-gpios = <&gpioa 8 1>;
>                 port {
>                         panel_in_rgb: endpoint {
>                                 remote-endpoint = <&controler_out_rgb>;
>                         };
>                 };
>         };
>
> Best regards
