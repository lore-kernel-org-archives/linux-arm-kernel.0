From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 08 Sep 2014 09:26:36 +0200
Subject: [PATCH v2 1/3] ARM: dts: Add Peach Pit dts entry for Atmel
 touchpad
In-Reply-To: <5405CA4F.10507@itdev.co.uk>
References: <1409066937-3574-1-git-send-email-javier.martinez@collabora.co.uk>
 <1409066937-3574-2-git-send-email-javier.martinez@collabora.co.uk>
 <53FD1001.30701@suse.de> <53FD8528.7090504@collabora.co.uk>
 <53FDD914.5090208@suse.de> <53FDE9B2.4040001@collabora.co.uk>
 <5405CA4F.10507@itdev.co.uk>
Message-ID: <540D5A2C.7080808@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nick,

On 09/02/2014 03:46 PM, Nick Dyer wrote:
> On 27/08/14 15:22, Javier Martinez Canillas wrote:
>>>> If there was a BTN_NONE or KEY_UNUSED it would had been better but I think
>>>> that making a distinction between these two cases (reserved pin vs GPIO
>>>> available but not used) is useful.
>>>
>>> Maybe Nick can comment here.
> 
> Yes, this is probably useful to document. However, I fear that it's not
> going to be obvious what the distinction is to someone who doesn't have the
> Atmel docs. Perhaps it would be clearer to just do something like:
> 
> 		linux,gpio-keymap = <KEY_RESERVED
> 		                     KEY_RESERVED
> 		                     KEY_RESERVED /* GPIO0 */
> 	        	             KEY_RESERVED /* GPIO1 */
> 		                     KEY_RESERVED /* GPIO2 */
> 		                     BTN_LEFT>;   /* GPIO3 */
> 
> If you omit any trailing KEY_RESERVED values it doesn't affect anything.
> 
> I was also going to suggest that you put something like "/* Atmel mXT224SL
> */" in your .dts file so it's clear what version of the maXTouch device you
> are configuring.
> 

Ok, I'll re-spin with those changes. Thanks a lot for your feedback.

Best regards,
Javier
