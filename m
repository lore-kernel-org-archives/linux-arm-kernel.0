From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jul 2014 16:24:10 +0100
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <53C0005A.4010001@gmail.com>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk> <53B7E86D.5040109@gmail.com>
 <20140711143733.GB21766@n2100.arm.linux.org.uk> <53C0005A.4010001@gmail.com>
Message-ID: <20140711152410.GC21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 05:18:50PM +0200, Sebastian Hesselbarth wrote:
> On 07/11/2014 04:37 PM, Russell King - ARM Linux wrote:
>> What's left is the display-subsystem { } entity to describe the makeup
>> of the subsystem.  That's not included as we currently need to pass
>> a block of memory, and the DT support for reserving chunks of memory
>> appeared (last time I looked) to only be botch-merged (only half of it
>> seems to have been merged making the whole reserved memory thing
>> totally useless - why people only half-merge features I've no idea.)
>
> There was a follow-up patch set for this some days ago
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/337686

Yes, I did a bit of digging a while back and found the outstanding
stuff, but it wasn't clear what's happening with it.  As it isn't
part of mainline, and I don't want to pick up further patches to
add dependencies, I decided it was better to stick with old proven
ways of a manually declared platform device for the time being.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
