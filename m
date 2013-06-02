From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 01 Jun 2013 23:07:50 -0600
Subject: [PATCH v2] video: simplefb: add mode parsing function
In-Reply-To: <20130601051223.GB5189@quad.lixom.net>
References: <1369626821-28494-1-git-send-email-acourbot@nvidia.com>
 <51A42ED5.2060104@wwwdotorg.org> <20130601051223.GB5189@quad.lixom.net>
Message-ID: <51AAD326.4040809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2013 11:12 PM, Olof Johansson wrote:
> On Mon, May 27, 2013 at 10:13:09PM -0600, Stephen Warren wrote:
>> On 05/26/2013 09:53 PM, Alexandre Courbot wrote:
>>> The naming scheme of simplefb's mode is precise enough to allow building
>>> the mode structure from it instead of using a static list of modes. This
>>> patch introduces a function that does this. In case exotic modes that
>>> cannot be represented from their name alone are needed, the static list
>>> of modes is still available as a backup.
...
>> As such, we should either:
>>
>> a) Just add new entries into the format array that already exists in the
>> driver. Given David's response, this might be simplest.
> 
> I think so too. Is this even needed? Do we have any users of the newer formats
> or is it just someone trying to feature-creep this driver to make the "simple"
> part of the name inaccurate? :)

Alex is working on board support for a new NVIDIA board, where IIRC the
bootloader sets up some 32-bit ARGB format for the panel.
