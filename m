From: ssimran@broadcom.com (Simran Rai)
Date: Fri, 6 Nov 2015 14:10:23 -0800
Subject: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <20151106103147.GZ18409@sirena.org.uk>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
 <20151104140746.GE1717@sirena.org.uk> <563BB5B0.5040501@broadcom.com>
 <20151106103147.GZ18409@sirena.org.uk>
Message-ID: <563D254F.9090000@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/6/2015 2:31 AM, Mark Brown wrote:
> On Thu, Nov 05, 2015 at 12:01:52PM -0800, Simran Rai wrote:
>> On 11/4/2015 6:07 AM, Mark Brown wrote:
>>> On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:
>>>> +  Interfaces grouping of serial port. In multi-channel stereo, use
>>>> +  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
>>>> +  multi-channel grouping, use "5_1".
>>> I don't really understand what this means or why this is not runtime
>>> configured.
>> By runtime configured, do you mean passing the channel grouping through
>> machine file? Is there any specific callback that I can use?
> No, this appears to just be setting the number of channels which is
> normally configured depending on how many channels userspace is playing.
This audio driver uses 'params_channels()' to determine the number of 
channels requested by userspace in TDM mode (multiple
channels on one audio port). Channel grouping is another mode where more 
than one audio ports are grouped together to form
3.1 or 5.1 surround sound and this feature has been implemented through 
device tree settings.
At this point, I will take out channel grouping functionality because it 
does not work as intended. In near future, once this feature
is fixed, how do you suggest implementing it in the driver?

Thanks,
Simran
