From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 09:41:22 -0700
Subject: [PATCH v5 5/8] pinctrl: Cygnus: define Broadcom Cygnus
 GPIO/PINCONF binding
In-Reply-To: <CACRpkdYy75-fH29W-pr5ExuQc6dfO1Xe5UtFr49GAdnVHyXuCg@mail.gmail.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>	<1425515756-321-6-git-send-email-rjui@broadcom.com>
 <CACRpkdYy75-fH29W-pr5ExuQc6dfO1Xe5UtFr49GAdnVHyXuCg@mail.gmail.com>
Message-ID: <54FDCD32.4080701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 3/9/2015 9:30 AM, Linus Walleij wrote:
> On Thu, Mar 5, 2015 at 1:35 AM, Ray Jui <rjui@broadcom.com> wrote:
> 
>> Document the GPIO/PINCONF device tree binding for Broadcom Cygnus SoC
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> (...)
> 
>> +- ngpios:
>> +    Total number of GPIOs the controller provides
> 
> Remind me again. Why don't we know this from the compatible string?

Is hard coding the number of GPIO pins in the driver based on compatible
string the preferred approach? If so, I can make the change. Note the
current driver only has one compatible string "brcm,cygnus-gpio." To do
this, I need to introduce 3 compatible strings "brcm,cygnus-asiu-gpio",
"brcm,cygnus-ccm-gpio", "brcm,cygnus-aon-gpio", and assign hard coded
ngpios to each of them during probe.

> 
> (I paused applying the patches here waiting for the answer.)
> 
> Yours,
> Linus Walleij
> 
