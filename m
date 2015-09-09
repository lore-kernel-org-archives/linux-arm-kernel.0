From: songjun.wu@atmel.com (Wu, Songjun)
Date: Wed, 9 Sep 2015 11:16:08 +0800
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <20150908122322.GB9751@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk> <55EEAC01.3080409@atmel.com>
 <20150908122322.GB9751@sirena.org.uk>
Message-ID: <55EFA478.1000109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/8/2015 20:23, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 05:36:01PM +0800, Wu, Songjun wrote:
>> On 9/8/2015 00:23, Mark Brown wrote:
>
>>> OK, so that's not actually what the code was doing - it had separate
>>> enums for bass, mid and treble.  If you make this a single enum with all
>>> the above options in it that seems like the best way of handling things.
>
>> A single enum seems not very friendly to user, there are tree EQs, bass,
>> medium and treble.
>> So I create tree enum controls to control three EQs.
>> The 'get' function is replaced by 'classd_get_eq_enum', if user operates one
>> of the tree EQ controls, the other two EQs will show 0 dB.
>
> If you want to have three controls you need to write code so that the
> user can only change one of them from 0dB at once, returning an error
> otherwise.  That was why it looked like they were three separate
> controls.
>
If user operates two or tree controls at the same time, for my 
understanding, these operations are serial actually in kernel, not 
parallel, and the last operation will be effective. I only write the 
function 'classd_get_eq_enum' to get the enumeration value, if user 
changes one of controls, the other controls will get 0dB. Is my 
understanding correct?
