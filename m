From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 14 Sep 2011 13:10:47 -0600
Subject: [PATCH 2/2] input: samsung-keypad: Add device tree support
In-Reply-To: <CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
	<CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
	<20110914171318.GA24425@ponder.secretlab.ca>
	<CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
Message-ID: <CACxGe6uh82U_uFUBCdk4anDywUre974xU8OqEpvVq7AF5Oj8KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 12:09 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 14 September 2011 22:43, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
>>> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>>> >> +- Keys represented as child nodes: Each key connected to the keypad
>>> >> + ?controller is represented as a child node to the keypad controller
>>> >> + ?device node and should include the following properties.
>>> >> + ?- keypad,row: the row number to which the key is connected.
>>> >> + ?- keypad,column: the column number to which the key is connected.
>>> >> + ?- keypad,key-code: the key-code to be reported when the key is pressed
>>> >> + ? ?and released.
>>> >
>>> > What defines the meanings of the key codes?
>>>
>>> The key-code could be any value which the system would want the keypad
>>> driver to report when that key is pressed.
>>
>> Are they linux keycodes? ?If so, then this property name can
>> probably be linux,code. ?There is already precedence for that
>> usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt. ?(I
>> would personally prefer "linux,key-code", but sometimes it is better
>> to go with existing precidence) You could also use linux,input-type as
>> specified in that binding.
>
> Ok. For linux, "keypad,key-code" would mean linux keycodes. The
> property name 'keypad,key-code' was chosen since it can be reused on
> non-linux platforms as well. I did have a look at
> Documentation/devicetree/bindings/gpio/gpio-keys.txt while doing this,
> but preferred using 'keypad,key-code' since it would be generic. Given
> a choice, I would like to retain this.

This was debated a bit on the gpio-keys binding.  The binding *must*
specify where it is getting the keycodes from.  For the gpio-keys
binding, it was decided that the Linux keycodes were sufficient since
they are exported to userspace, and therefore part of the stable
kernel ABI (they will never change).  "keypad,key-code" is completely
useless as a generic binding since it doesn't specify where the
keycode meanings come from.  Besides, "linux,code" can be reused on
non-linux platforms too, it just means that the authoritative source
of the keycodes is the Linux kernel.

g
