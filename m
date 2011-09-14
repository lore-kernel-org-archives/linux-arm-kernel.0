From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 14 Sep 2011 23:39:03 +0530
Subject: [PATCH 2/2] input: samsung-keypad: Add device tree support
In-Reply-To: <20110914171318.GA24425@ponder.secretlab.ca>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
	<1315916779-21793-3-git-send-email-thomas.abraham@linaro.org>
	<20110914161144.GF3134@ponder.secretlab.ca>
	<CAJuYYwSNaVCnHFTMtW0RZLGLaS+iKBibWYwn5mqNT-0EW31yAQ@mail.gmail.com>
	<20110914171318.GA24425@ponder.secretlab.ca>
Message-ID: <CAJuYYwRP2DGge1aHz-CWMnUrdz686s6X5Fp=LvRkM35VQS1XYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 14 September 2011 22:43, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Sep 14, 2011 at 10:19:22PM +0530, Thomas Abraham wrote:
>> Hi Grant,
>>
>> On 14 September 2011 21:41, Grant Likely <grant.likely@secretlab.ca> wrote:
>> > On Tue, Sep 13, 2011 at 05:56:19PM +0530, Thomas Abraham wrote:
>> >> Add device tree based discovery support for Samsung's keypad controller.
>> >>
>> >> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> >> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> >> ---
>> >> ?.../devicetree/bindings/input/samsung-keypad.txt ? | ? 88 ++++++++++
>> >> ?drivers/input/keyboard/samsung-keypad.c ? ? ? ? ? ?| ?177 ++++++++++++++++++--
>> >> ?2 files changed, 253 insertions(+), 12 deletions(-)
>> >> ?create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
>> >>

[...]

>> >> +- Keys represented as child nodes: Each key connected to the keypad
>> >> + ?controller is represented as a child node to the keypad controller
>> >> + ?device node and should include the following properties.
>> >> + ?- keypad,row: the row number to which the key is connected.
>> >> + ?- keypad,column: the column number to which the key is connected.
>> >> + ?- keypad,key-code: the key-code to be reported when the key is pressed
>> >> + ? ?and released.
>> >
>> > What defines the meanings of the key codes?
>>
>> The key-code could be any value which the system would want the keypad
>> driver to report when that key is pressed.
>
> Are they linux keycodes? ?If so, then this property name can
> probably be linux,code. ?There is already precedence for that
> usage in Documentation/devicetree/bindings/gpio/gpio-keys.txt. ?(I
> would personally prefer "linux,key-code", but sometimes it is better
> to go with existing precidence) You could also use linux,input-type as
> specified in that binding.

Ok. For linux, "keypad,key-code" would mean linux keycodes. The
property name 'keypad,key-code' was chosen since it can be reused on
non-linux platforms as well. I did have a look at
Documentation/devicetree/bindings/gpio/gpio-keys.txt while doing this,
but preferred using 'keypad,key-code' since it would be generic. Given
a choice, I would like to retain this.

>
>>
>> >
>> >> +
>> >> +Optional Properties specific to linux:
>> >> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
>> >> +- linux,keypad-wakeup: use any event on keypad as wakeup event.
>> >
>> > Is this really a linux-specific feature?
>>
>> Yes, it is a property defined by the linux subsystems. A non-linux
>> system might not have such features.
>
> I was specifically referring to the wakeup property, but okay, I can
> see the argument that it is linux-specific because it is usage-policy
> related.
>
> g.

Thanks for your review.

Regards,
Thomas.
