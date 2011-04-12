From: kzak@redhat.com (Karel Zak)
Date: Tue, 12 Apr 2011 12:11:35 +0200
Subject: [PATCH RFC] util-linux: readprofile: don't stop parsing at
	__init_end
In-Reply-To: <1302255353-1622-1-git-send-email-ratbert.chuang@gmail.com>
References: <1302255353-1622-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <20110412101135.GA7869@nb.net.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 05:35:53PM +0800, Po-Yu Chuang wrote:
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
> 
> Some architectures like ARM place __init_end before .text section.
> If any function in .init section is hit while profiling, readprofile
> stops at __init_end.  That means if we enable profiling at boot time,
> the profiler probably hits init functions and readprofile does not
> work well unless we reset profiling buffer with -r option.
> 
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
>  sys-utils/readprofile.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
