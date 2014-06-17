From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 17 Jun 2014 08:31:27 +0200
Subject: [PATCH 1/2] touchscreen: sun4i-ts: A10 (sun4i) has double the
 temperature precision
In-Reply-To: <20140616213048.GA422@core.coreip.homeip.net>
References: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
 <1402943069-19420-2-git-send-email-hdegoede@redhat.com>
 <20140616213048.GA422@core.coreip.homeip.net>
Message-ID: <539FE0BF.7030708@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/16/2014 11:30 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Mon, Jun 16, 2014 at 08:24:28PM +0200, Hans de Goede wrote:
>> Testing has revealed that the temperature in the rtp controller of the A10
>> (sun4i) SoC has a resolution of 50 milli degrees / step, where as the
>> A13 (sun5i) and later models have 100 milli degrees / step.
>>
>> Add a new sun5i-a13-ts compatible to differentiate the newer models and
>> set the resolution based on the compatible string.
>>
>> This fixes the temperature reported on the A10 being twice as high as expected.
> 
> Should we maybe add explicit temperature steps property so that we won;t
> need to patch again if they decided to change resolution again?

I can understand where your coming from, but in general the rule for
devicetree bindings is to not add properties for things which are purely
dependent on the SoC generation. Those must be deferred from the compatible
string.

Regards,

Hans
