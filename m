From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 1 Aug 2016 07:55:10 -0700
Subject: [PATCH v3 0/6] power: add power sequence library
In-Reply-To: <CAOMZO5Dv_X-u6qKqAWtysAqmMw91bVoAaRvnc81yUGDxbd27rA@mail.gmail.com>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <579A2B38.3000202@gmail.com>
 <CAOMZO5Dv_X-u6qKqAWtysAqmMw91bVoAaRvnc81yUGDxbd27rA@mail.gmail.com>
Message-ID: <579F62CE.1050900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/28/2016 09:41 AM, Fabio Estevam wrote:
> Hi Joshua,
>
> On Thu, Jul 28, 2016 at 12:56 PM, Joshua Clayton
> <stillcompiling@gmail.com> wrote:
>
>> I assume there is a v4 coming due to rmk's comments on patch 5.
>> I couldn't figure out where to null the of_node in error paths, but in testing
>> we did put a line of code to null the of_node on release.
>>
>> but...
>> As an aside,
>> I was hoping this series would magically fix a problem
>> with the imx6q-evi which has forced us to disable
>> runtime power management. But it did not. :(
> I also see a similar problem on a mx28 board with a hub.
>
> Does it help in your case if you pass 'usbcore.autosuspend=-1' in the
> kernel command line?
>
> Regards,
>
> Fabio Estevam
Thanks a million, Fabio!

'usbcore.autosuspend=-1' quiets the errors.

~joshua

P.S. I guess this technically is a bug in chipidea usb.
I'll give it a quick once over, though I am not very familiar
with USB core or the CI driver.
