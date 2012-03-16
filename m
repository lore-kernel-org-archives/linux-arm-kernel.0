From: arjan@linux.intel.com (Arjan van de Ven)
Date: Thu, 15 Mar 2012 18:52:05 -0700
Subject: [PATCHv2 3/5] cpuidle: add support for states that affect multiple
 cpus
In-Reply-To: <CAMbhsRS3J2vruru8i4r1-cB9aJLYW9y1bP0vv7=L3q1JP77ttg@mail.gmail.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
 <1331749794-8056-4-git-send-email-ccross@android.com> <87lin18l7o.fsf@ti.com>
 <CAMbhsRS3J2vruru8i4r1-cB9aJLYW9y1bP0vv7=L3q1JP77ttg@mail.gmail.com>
Message-ID: <4F629CC5.60402@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2012 5:20 PM, Colin Cross wrote:
> Oops, dropped the atomic_dec when I merged from two separate functions
> for up and down to a single function that takes a bool.

generally in Linux we tend to not like "multiplexer" common functions
like this.

my suggestion: make your current function a __ prefixed one, then
provide 2 small inlines that call the __ one...
