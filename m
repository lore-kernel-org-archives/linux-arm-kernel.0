From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 11 Nov 2012 14:51:31 -0700
Subject: S-o-b for 48efdd2 "Add a pm_power_off function that resets us,
 ..."
In-Reply-To: <2C2B34F818605C4A9351ED6A537A43841DE6D823@SJEXCHMB09.corp.ad.broadcom.com>
References: <508CA4C4.5060407@wwwdotorg.org> <509C7328.9030104@wwwdotorg.org>
 <2C2B34F818605C4A9351ED6A537A43841DE6D823@SJEXCHMB09.corp.ad.broadcom.com>
Message-ID: <50A01DE3.8030003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2012 04:09 AM, Dominic Cobley wrote:
> I'm happy to give permission for s.o.b. to be commits made by me. Is that sufficient?

Assuming you've read Documentation/SubmittingPatches and can fulfill the
conditions to apply an S-o-b (noting that many commits in your 3.6.y
branch are authored by other people, so you'd need their S-o-b first
most likely)...

For individual commits, you can always respond to the email requests
with the desired S-o-b line in question, i.e. just write the following
with your name/email:

Signed-off-by: Random J Developer <random@developer.example.org>

Perhaps you can also just state that the S-o-b line you write applies to
any commit currently in th 3.6.y branch.

> If that's not sufficient can you give me git commands that will do what you want?

Something like the following would do:

git checkout rpi-3.6.y

git rebase -i c6092bb74442d4ee1dfea60e2934915836f53528 # 3.6.1

In the editor that pops up, for any commit that you can S-o-b, change
"pick" to "reword" or "edit", then save the document. See the
instructions in the editor.

If you chose to use "reword", the editor will pop up again for each
commit. Write or paste your S-o-b into the commit description in the
appropriate place.

If you chose to use "edit", git will return the shell, and then you run
"git commit --amend -s" to edit the commit description (-s adds your
S-o-b automatically) and then "git rebase --continue" to continue the
rebase operation at the next commit.

Finally, push the modified branch to the git server.

Note that this process will change the git commit IDs of the commits in
your branch, which will be rather unfortunate for downstream users, and
will probably break unmerged github pull requests. Depending on any
"customer's" familiarity with git, this may be a minor or major issue...
For this reason, it's a good idea to add the S-o-b lines before you
first push the commits to the git server; use "git commit -s" rather
than "git commit", and making sure any contributors whose patches you
accept have done the same themselves.

Thanks!
