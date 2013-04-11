From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 11 Apr 2013 10:10:09 -0600
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <CAMuHMdWFVi=AFR8prins0mees4BFUUXirCC2swyQPwGs7Tt8uQ@mail.gmail.com>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <CAMuHMdWFVi=AFR8prins0mees4BFUUXirCC2swyQPwGs7Tt8uQ@mail.gmail.com>
Message-ID: <5166E061.1050008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 04:42 AM, Geert Uytterhoeven wrote:
> On Thu, Apr 4, 2013 at 4:39 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> +       { "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
> 
> Why "r5g6b5" instead of "rgb565", which is what's commonly used?

Both representations appear commonly used.

I mentioned my rationale in response to V1: "r5g6b5" is a much more
well-defined structure. It's directly algorithmically parse-able if
required, whereas you'd need somewhat more complex heuristics to
determine exactly what rgb565 or argb2101010 mean, since all the numbers
are run together without delimiters.
