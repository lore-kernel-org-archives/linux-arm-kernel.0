From: bjorn@kryo.se (Bjorn Andersson)
Date: Sat, 5 Oct 2013 23:11:36 -0700
Subject: [PATCH RFC v2 3/5] spmi: add generic SPMI controller binding
 documentation
In-Reply-To: <521D2047.8030300@wwwdotorg.org>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <e42576b69ef3d4e624fbfa2f32f6f79a931b55d6.1377202730.git.joshc@codeaurora.org>
 <5217DB0C.7000101@wwwdotorg.org>
 <20130827170120.GR4035@joshc.qualcomm.com>
 <521D2047.8030300@wwwdotorg.org>
Message-ID: <CAJAp7Oi-bPytsLtsppdanOi_p0Y5vfBriGB-B5by7w5Z7SGU-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 2:55 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/27/2013 11:01 AM, Josh Cartwright wrote:
> ...
> cell 0 - address type (0: master, 1: unique ID, 2: group ID, ...)

I think it would make sense to have the master id as a property of the
bus, as you could consider this to indicate different buses and then
usid, gsid and base being part of the reg.

> cell 1 - address value

I did hack up Josh patchset to read a reg touple of <usid, base>
instead of just usid. I stored the second value in the spmi_device
struct for easy access, but maybe it should be done like on
codeaurora; in a resource?
I believe this looks nice, but as I haven't read the mipi spec I
wonder, will there be a case where you don't have an offset/base?
Should it just be made optional?

Can we make the address <usid, [base]> and have the code populate a
resource based on a reg-names property? That way it would be possible
to extend it to support gsid in case we want to (would require
reg-names though).


With the hack to Josh's patchset I quickly ported qpnp-revision and
qpnp-vibrator, and it seems to work quite nicely.

Regards,
Bjorn
