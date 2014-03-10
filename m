From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Mar 2014 18:40:58 +0200
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<20140228162752.GU21483@n2100.arm.linux.org.uk>	<5310BDE3.60603@ti.com>	<20140228165628.GX21483@n2100.arm.linux.org.uk>	<53143796.2050309@ti.com>
 <CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
Message-ID: <531DEB1A.5090509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 10/03/14 18:05, Rob Herring wrote:

>> Russell's point was that these connector bindings are very generic, i.e.
>> they are not for any particular chip from a particular vendor, but for
>> any connector for DVI, HDMI or analog-tv. And he's worried that maybe we
>> shouldn't define such generic bindings without consulting the whole
>> device-tree community (i.e including non-linux users).
> 
> So re-work it to be generic and send it out. DT maintainers would
> rarely disagree that something shouldn't be made generic.

They (in this series) are already designed to be generic.

I should perhaps re-word the question: we are concerned whether these
bindings are good for all the users, not just us, and whether there
already exists something that overlaps.

Afaik, there's nothing overlapping. And I don't see why they wouldn't be
good for all users (with the few minor modifications that have been
discussed in this thread). But, if I gathered right, Russell would like
some kind of ack from someone who might know better than us.

So is it enough to have posted these, and gotten acks from the people
involved, or should we get acks from DT maintainers also?

Is there a way to get the attention of, say, BSD people, or should we
just presume they'll follow the list?

>> So the question is, is there such a community and a forum to bring up
>> this kind of things? If yes, should we bring this up there? If yes, what
>> kind of things in general should be brought into the attention of
>> non-linux users?
> 
> devicetree list is just that. It is not just for Linux. There is the
> newly created devicetree-spec at vger.kernel.org which is for more
> core/common binding discussion.

Ok.

>> What I wonder here is that while a thing like DVI connector is, of
>> course, more generic than, say, "ti,tfp410" encoder chip, but isn't the
>> case still the same: we're defining global bindings for hardware that
>> should work for everyone, not only Linux users?
> 
> Defining the connectors in DT is a useful thing although mainly when
> you have multiple connectors of the same type. Labels for composite,
> SVideo, VGA, DVI, HDMI seem less useful to me. Describing position or
> printed label (like front vs. rear connections) seem more useful to
> me.

My point above was that it feels mentally easier to define bindings for
one particular IP block or chip, than defining bindings for a more
generic thing like "HDMI connector". But, in the end, I believe they
both should go through similar review, and there's no such difference.

As for the labels, they can be anything that makes sense for that
particular board. It can be "HDMI Front", if such makes sense, or
"HDMI-2" if the connector has such physical printed label. Or, say,
"Main LCD", "Secondary LCD". It's a free form text that is given to the
user.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/d894abf5/attachment-0001.sig>
