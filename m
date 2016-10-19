From: lstoakes@gmail.com (Lorenzo Stoakes)
Date: Wed, 19 Oct 2016 09:58:15 +0100
Subject: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
In-Reply-To: <20161018153050.GC13117@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz>
Message-ID: <20161019085815.GA22239@lucifer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
> I am wondering whether we can go further. E.g. it is not really clear to
> me whether we need an explicit FOLL_REMOTE when we can in fact check
> mm != current->mm and imply that. Maybe there are some contexts which
> wouldn't work, I haven't checked.

This flag is set even when /proc/self/mem is used. I've not looked deeply into
this flag but perhaps accessing your own memory this way can be considered
'remote' since you're not accessing it directly. On the other hand, perhaps this
is just mistaken in this case?

> I guess there is more work in that area and I do not want to impose all
> that work on you, but I couldn't resist once I saw you playing in that
> area ;) Definitely a good start!

Thanks, I am more than happy to go as far down this rabbit hole as is helpful,
no imposition at all :)
