From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Feb 2017 08:07:56 -0600
Subject: [PATCH v2 4/9] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <2b409ff7-54fe-4110-6495-1cc54585e5e2@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
 <1486738489-22154-5-git-send-email-yannick.fertre@st.com>
 <20170216023408.apqukipi5zzkrk7j@rob-hp-laptop>
 <2b409ff7-54fe-4110-6495-1cc54585e5e2@st.com>
Message-ID: <CAL_JsqLBZ0DGP62yGb2GjNZMto9hWce_HWNCX5iWhbrnE3ae_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 5:01 AM, Yannick FERTRE <yannick.fertre@st.com> wrote:
>
>
> On 02/16/2017 03:34 AM, Rob Herring wrote:
>> On Fri, Feb 10, 2017 at 03:54:44PM +0100, Yannick Fertre wrote:
>>> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
>>> ---
>>>  .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>> new file mode 100644
>>> index 0000000..f59e3c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
>>> @@ -0,0 +1,7 @@
>>> +Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
>>> +
>>> +Required properties:
>>> +- compatible: should be "ampire,am-480272h3tmqw-t01h"
>>
>> No GPIO controls or power supply for this panel?
>>
>> Rob
>>
>
> Hi Rob,
> thank for your reply.
> There is no gpio or power supply control for this panel with the eval
> board stm429x9i.

You need to describe what the panel has, not what you have control of
or not on a particular board.

> This binding is similar to all panel bindings which are link to panel
> simple. Details on gpio & power supply are describe with simple-panel
> binding.

simple-panel.txt provides what possible standard properties there are,
not whether a panel uses them. The power supply needs to be explicit
because I don't know if you forgot and there's really 2 supplies or
you are using "power-supply" for a single supply.

Rob
